package kr.co.sist.member.dao;

import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.exceptions.PersistenceException;

import kr.co.sist.chipher.DataEncryption;

/**
 * 업무로직의 처리<br>
 * 1. 총 레코드 수 구하기<br>
 * 2. 한 화면에 보여줄 레코드의 수<br>
 * 3. 총 페이지 수<br>
 * 4. 검색의 시작번호를 구하기<br>
 * 5. 끝 번호<br>
 * 6. 시작번호, 끝번호를 사용한 게시글 조회<br>
 * 7. 페이지네이션<br>
 * 
 * ------------ <br>
 * 1. 아이디 중복확인<br>
 * 2. 회원 정보 추가<br>
 * 3. 회원 관심언어 추가하기 -> 배열로 만들기 <br>
 * 
 */
public class WebMemberService {

	private static WebMemberService wms;

	private WebMemberService() {

	}

	public static WebMemberService getInstance() {

		if (wms == null) {

			wms = new WebMemberService();
		}
		return wms;
	}// getInstance

	/**
	 * 입력된 아이디가 사용중인지 판단하는 일
	 * 
	 * @param id 중복확인할 ID
	 * @return true - 사용가능, false - 사용불가
	 */
	public boolean searchIdDup(String id) {

		boolean flag = false;

		WebMemberDAO wmDAO = WebMemberDAO.getInstance();
		try {
			String resultId = wmDAO.selectIdDup(id);

			flag = (resultId == null || "".equals(resultId));

		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		return flag;
	}// searchIdDup

	public boolean addWebMember(WebMemberVO wmVO, HttpServletRequest request) {

		boolean flag = false;
		WebMemberDAO wmDAO = WebMemberDAO.getInstance();

		// 접속자의 ip주소를 저장( 부인방지용 )
		wmVO.setIp(request.getRemoteAddr());

		if (wmVO.getSave() == null) {
			wmVO.setSave("N");
		} // end if

		try {

			// 저장할 데이터의 중요도에 따라 일방향 Hash, 양방향 암호화 수행
			// 비번 : 일방향 Hash
			wmVO.setPass(DataEncryption.messageDigest("SHA-1", wmVO.getPass()));

			DataEncryption de = new DataEncryption("abcdef0123456789");
			// 이름, 이메일,전화번호 양방향 암호화처리
			wmVO.setName(de.encrypt(wmVO.getName()));
			wmVO.setCellphone(de.encrypt(wmVO.getCellphone()));
			wmVO.setEmail(de.encrypt(wmVO.getEmail()));

			// 관심언어를 배열로 생성
			WebMemberLangVO[] wmlVOArr = null;

			String[] lang = wmVO.getLang();
			int langCnt = 0;

			if (lang != null) {
				langCnt = lang.length;
				wmlVOArr = new WebMemberLangVO[langCnt];

				for (int i = 0; i < langCnt; i++) {
					wmlVOArr[i] = new WebMemberLangVO(wmVO.getId(), lang[i]);
				}
			}

			// 입력된 회원 정보를 DB에 추가
			int commitCnt = wmDAO.insertWebMember(wmVO, wmlVOArr);
			flag = commitCnt == (langCnt + 1);

		} catch (NoSuchAlgorithmException nae) {
			nae.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return flag;
	}

	public static void main(String[] args) {

		System.out.println(WebMemberService.getInstance().searchIdDup("test"));

	}

}
