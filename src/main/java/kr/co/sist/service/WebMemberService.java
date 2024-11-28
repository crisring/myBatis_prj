package kr.co.sist.service;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;

import day1118.SelectExam3;
import kr.co.sist.chipher.DataDecryption;
import kr.co.sist.domain.BoardInfoDomain;
import kr.co.sist.domain.WebMemberDomain;

public class WebMemberService {

	private static WebMemberService wmService;

	private WebMemberService() {

	}

	public static WebMemberService getInstance() {

		if (wmService == null) {
			wmService = new WebMemberService();

		}
		return wmService;

	}

	public List<WebMemberDomain> searchWebMember(String adminRole) {

		List<WebMemberDomain> list = null;

		SelectExam3 se3 = SelectExam3.getInstance();

		try {
			list = se3.join();

		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		// 모든 정보 확인 가능
		if ("s".equals(adminRole)) {
			DataDecryption dd = new DataDecryption("abcdef0123456789");

			try {

				WebMemberDomain wmd = null;
				String tel = "";
				String email = "";

				for (int i = 0; i < list.size(); i++) {
					wmd = list.get(i);

					wmd.setName(dd.decrypt(wmd.getName()));

					tel = wmd.getTel();

					if (tel != null && !"".equals(tel)) {
						wmd.setTel(dd.decrypt(wmd.getTel()));

					}

					email = wmd.getEmail();

					if (email != null && !"".equals(email)) {
						wmd.setEmail(dd.decrypt(email));

					}

					list.set(i, wmd);
				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		return list;
	}// searchWebMember

	public List<BoardInfoDomain> searchBoardMember(String adminRole) {

		List<BoardInfoDomain> list = null;

		SelectExam3 se3 = SelectExam3.getInstance();

		try {
			list = se3.joinSubQuery();

		} catch (PersistenceException pe) {
			pe.printStackTrace();
		}

		// 모든 정보 확인 가능
		if ("s".equals(adminRole)) {
			DataDecryption dd = new DataDecryption("abcdef0123456789");

			try {

				for (BoardInfoDomain wmd : list) {
					wmd.setName(dd.decrypt(wmd.getName()));

				}

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

		return list;
	}// searchBoardMember

	public static void main(String[] args) {

		System.out.println(WebMemberService.getInstance().searchBoardMember("s"));

	}

}
