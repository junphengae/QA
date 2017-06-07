package com.bitmap.webservice;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.Date;

import javax.el.ELException;


import com.bitmap.dbconnection.mysql.dbpool.DBPool;
import com.bitmap.dbutils.DBUtility;
import com.bitmap.webutils.WebUtils;

public class WebServiceUpdateTS {
	
	public static String tableName = "web_service_update";
	private static String[] keys = {"table_name","sync_date"};
	private static String[] fieldNames = {"sync_date","table_name","status"};
	
	public static void main() throws Exception {
		
	WebServiceUpdateTS.getWebServiceUpdateUpdate(new Date());
	}

	private static void getWebServiceUpdateUpdate(Date date) {
	// TODO Auto-generated method stub
	
	}
	private static boolean check(WebServiceUpdateBean entity, Connection conn) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
		return DBUtility.getEntityFromDB(conn, tableName, entity, keys);
	}
	
	public  static boolean check(WebServiceUpdateBean entity) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
		Connection conn = DBPool.getConnection();
		boolean check = false;
		check = DBUtility.getEntityFromDB(conn, tableName, entity, keys);
		conn.close();
		return check;
	}
	
	public static boolean insert(WebServiceUpdateBean entity) throws IllegalAccessException, InvocationTargetException, SQLException{
		boolean has = false;
		Connection conn = DBPool.getConnection();
		if (check(entity, conn)) {
			has = true;
		} else {
			entity.setSync_date(DBUtility.getDBCurrentDateTime());
			entity.setStatus("N");
			DBUtility.insertToDB(conn, tableName, entity);
		}
		conn.close();
		return has;
	}
	
	public static void update(WebServiceUpdateBean entity) throws IllegalAccessException, InvocationTargetException, SQLException{
		Connection conn = DBPool.getConnection();
		entity.setSync_date(DBUtility.getDBCurrentDateTime());
		DBUtility.updateToDB(conn, tableName, entity, fieldNames, keys);
		conn.close();
	}
	
	public static WebServiceUpdateBean select(WebServiceUpdateBean entity) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
		Connection conn = DBPool.getConnection();
		DBUtility.getEntityFromDB(conn, tableName, entity, keys);
		conn.close();
		return entity;
	}
	
	public static WebServiceUpdateBean selectdate(Connection conn,String table_name) throws Exception{
			
		WebServiceUpdateBean entity = new WebServiceUpdateBean();
			
			try {
					String sql ="SELECT MAX(sync_date) AS sync_date FROM  web_service_update WHERE table_name = '"+ table_name +"'";
					
					Statement st = conn.createStatement();
					ResultSet rs = st.executeQuery(sql);
					
					
					if (rs.next()) {
						DBUtility.bindResultSet(entity, rs);
					}
					
					if (entity.getSync_date() == null) {
						
						String time = "0001-01-01 01:01:00.0" ;
						Timestamp ts = Timestamp.valueOf(time);
						entity.setSync_date(ts);
						
					}
					rs.close();
					st.close();
					
					
			} catch (Exception e) {
				conn.rollback();
				conn.close();
				throw new Exception(e.getMessage());
			}
			return entity;
		
	} 
	public static void insertServiceUpdate(Connection conn ,String table_name) throws Exception{
		
		try {
				WebServiceUpdateBean entity = new WebServiceUpdateBean();
				entity.setTable_name(table_name);
				entity.setSync_date(DBUtility.getDBCurrentDateTime());
				entity.setStatus("N");
				
				DBUtility.insertToDB(conn, tableName, entity);
			
				
		} catch (Exception e) {
				conn.rollback();
				conn.close();
				throw new Exception(e.getMessage());
		}
				
	}
 

}
