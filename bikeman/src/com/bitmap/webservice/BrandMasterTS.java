package com.bitmap.webservice;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.bitmap.dbconnection.mysql.dbpool.DBPool;
import com.bitmap.dbutils.DBUtility;
import com.mysql.jdbc.Statement;

public class BrandMasterTS {
	
	public static String tableName = "mk_brands";
	
	public static void main(String arg) throws Exception{
		BrandMasterTS.getBrandUpdate(new Date());
	}
	public static List<BrandMasterBean> getBrandUpdate(Date dd) throws Exception{
		
		List<BrandMasterBean> list = new ArrayList<BrandMasterBean>();
		
		Connection conn = null;
		
		try{
			
			String sql = "SELECT * FROM  "+tableName+"  WHERE update_date > '" + DBUtility.DATE_DATABASE_FORMAT.format(dd)+"'";
			
			conn = DBPool.getConnection();
			Statement st = (Statement) conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			while(rs.next()){
				
				BrandMasterBean entity = new BrandMasterBean();
				DBUtility.bindResultSet(entity, rs);
				list.add(entity);
			}
			rs.close();
			st.close();
			
			
		}catch (Exception e) {
			throw new Exception("BrandMasterTSException: " + e.getMessage());
		}finally{
			if (conn != null) {
				conn.close();
			}
		}
		
		return list;
		
	}

}
