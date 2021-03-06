package com.bitmap.webservice;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.bitmap.dbconnection.mysql.dbpool.DBPool;
import com.bitmap.dbutils.DBUtility;

public class PartCategoriesTS {
		
	public static String tableName = "pa_categories";
	public static void main(String[] arg) throws Exception{
		
		PartCategoriesTS.getPartCategoriesUpdate(new Date());
	}
	public static List<PartCategoriesBean> getPartCategoriesUpdate(Date dd) throws Exception {
		
		List<PartCategoriesBean> list = new ArrayList<PartCategoriesBean>();
		
		Connection conn = null;
		
		try{
			
			String sql = "SELECT * FROM "+tableName+" WHERE update_date > '" + DBUtility.DATE_DATABASE_FORMAT.format(dd) + "'";
			
			conn = DBPool.getConnection();
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			while (rs.next()) {
				PartCategoriesBean entity = new PartCategoriesBean();
				DBUtility.bindResultSet(entity, rs);
				list.add(entity);
			}
			
			rs.close();
			st.close();
			
		}catch (Exception e) {
			throw new Exception("PartCategoriesTSException: " + e.getMessage());
		}finally {
			
			if (conn != null) {
				conn.close();
			}
		}
		
		return list;
		
	
		
		
	}
	

}
