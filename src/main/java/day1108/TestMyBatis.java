package day1108;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class TestMyBatis {

	public static void main(String[] args) {

		try {
			// 1. 설정파일과 스트림으로 연결
			Reader reader = Resources.getResourceAsReader("day1108/mybatis-config.xml");
			System.out.println(reader);

			// 2. MyBatis와 framework 생성
			SqlSessionFactory ssf = new SqlSessionFactoryBuilder().build(reader);

			// 3. MyBatis Handler 얻기
			SqlSession handler = ssf.openSession();

			// 4. 쿼리수행 후 결과 얻기
			List<String> dnameList = handler.selectList("kr.co.sist.test.selectAllDname");
			System.out.println(dnameList);

			// 5. handler 종료
			handler.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
