package com.bitmap.bean.parts;
	import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.bitmap.bean.sale.Models;
import com.bitmap.dbconnection.mysql.dbpool.*;
import com.bitmap.dbutils.DBUtility;

	public class PartCategories {
		public static String tableName = "pa_categories";
		public static String[] keys = {"cat_id"};
		public static String[] fieldNames = {"cat_id", "group_id", "cat_name_short", "cat_name_th", "create_by", "create_date"};

		String cat_id = "";
		String group_id = "";
		String cat_name_short = "";
		String cat_name_th = "";
		String create_by = "";
		Timestamp create_date = null;
		String update_by = "";
		Timestamp update_date = null;
		
		private PartGroups UIGroup = new PartGroups();
		public PartGroups getUIGroup() {return UIGroup;}
		public void setUIGroup(PartGroups uIGroup) {UIGroup = uIGroup;}
		
		
		public  static boolean check(PartCategories entity) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			Connection conn = DBPool.getConnection();
			boolean check = false;
			check = DBUtility.getEntityFromDB(conn, tableName, entity, keys);
			conn.close();
			return check;
		}
		public  static boolean check(String cat_id) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			PartCategories entity = new PartCategories();
			entity.setCat_id(cat_id);
			return check(entity);
		}
		
		
		public static void insert(PartCategories entity) throws IllegalAccessException, InvocationTargetException, SQLException{
			Connection conn = DBPool.getConnection();
			entity.setCat_id(DBUtility.genNumber(conn, tableName, "cat_id"));
			entity.setGroup_id(entity.getGroup_id());
			entity.setCreate_date(DBUtility.getDBCurrentDateTime());
			entity.setUpdate_by(entity.getCreate_by());
			entity.setUpdate_date(DBUtility.getDBCurrentDateTime());
			//////System.out.println("XX : "+entity.getCat_id());
			DBUtility.insertToDB(conn, tableName, entity);
			conn.close();
		}
		
		private static String genID(String group_id, Connection conn) throws NumberFormatException, SQLException{
			String sql = "SELECT cat_id FROM " + tableName + " WHERE group_id='" + group_id + "' ORDER BY (cat_id*1) DESC";
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			String id = "1";
			if (rs.next()) {
				id = (Integer.parseInt(rs.getString("cat_id")) + 1) + "";
			}
			rs.close();
			st.close();
			return id;
		}
		
		public static PartCategories select(String cat_id,String group_id) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			PartCategories entity = new PartCategories();
			entity.setCat_id(cat_id);
			entity.setGroup_id(group_id);
			select(entity);
			return entity;
		}
		
		public static PartCategories select(String cat_id,String group_id, Connection conn) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			PartCategories entity = new PartCategories();
			entity.setCat_id(cat_id);
			entity.setGroup_id(group_id);
			select(entity, conn);
			return entity;
		}
		
		public static PartCategories select(PartCategories entity) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			Connection conn = DBPool.getConnection();
			DBUtility.getEntityFromDB(conn, tableName, entity, new String[]{"cat_id","group_id"});
			conn.close();
			return entity;
		}
		
		public static PartCategories select(PartCategories entity, Connection conn) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			DBUtility.getEntityFromDB(conn, tableName, entity, new String[]{"cat_id","group_id"});
			entity.setUIGroup(PartGroups.select(entity.getGroup_id(),conn));
			return entity;
		}
		
		public static List<PartCategories> selectList(String group_id) throws UnsupportedEncodingException, SQLException, IllegalAccessException, InvocationTargetException{
			String sql = "SELECT * FROM " + tableName + " WHERE group_id ='" + group_id + "' ORDER BY (cat_id*1)";
			Connection conn = DBPool.getConnection();
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			List<PartCategories> list = new ArrayList<PartCategories>();
			////////System.out.println(sql);
			while (rs.next()) {
				PartCategories entity = new PartCategories();
				DBUtility.bindResultSet(entity, rs);
				list.add(entity);
			}
			rs.close();
			st.close();
			conn.close();
			return list;
		}
		
	   	/**
		 * whan : shop
		 * <br>
		 * get group that have at branch
		 * @param group_id
		 * @param branch_id
		 * @return
		 * @throws UnsupportedEncodingException
		 * @throws SQLException
		 * @throws IllegalAccessException
		 * @throws InvocationTargetException
		 */
		public static List<PartCategories> selectList(String group_id,String branch_id) throws UnsupportedEncodingException, SQLException, IllegalAccessException, InvocationTargetException{
			String sql = "select distinct(inv_menu.cat_id),inv_categories.cat_name_th " +
						" from inv_menu,inv_menu_branch,inv_PartCategories where " +
						" inv_menu.mat_code = inv_menu_branch.mat_code " +
						" AND inv_menu_branch.branch_id = '" + branch_id + "' " +
						" AND inv_categories.group_id = '" + group_id + "' AND inv_menu.cat_id = inv_categories.cat_id  ORDER BY (inv_categories.cat_id*1) ASC";
			
			//////System.out.println(sql);
			
			Connection conn = DBPool.getConnection();
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			List<PartCategories> list = new ArrayList<PartCategories>();
			while (rs.next()) {
				PartCategories entity = new PartCategories();
				DBUtility.bindResultSet(entity, rs);
				list.add(entity);
			}
			rs.close();
			st.close();
			conn.close();
			return list;
		}
		public static List<String[]> ddl_th(String group_id) throws UnsupportedEncodingException, SQLException, IllegalAccessException, InvocationTargetException{
			String sql = "SELECT * FROM " + tableName + " WHERE group_id ='" + group_id + "' ORDER BY (cat_id*1)";
			////////System.out.println("SQL : "+ sql);
			Connection conn = DBPool.getConnection();
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			List<String[]> list = new ArrayList<String[]>();
			while (rs.next()) {
				PartCategories entity = new PartCategories();
				DBUtility.bindResultSet(entity, rs);
				list.add(new String[]{entity.getCat_id(),entity.getCat_name_th()});
			}
			rs.close();
			st.close();
			conn.close();
			return list;
		}
		
		public static void update(PartCategories entity) throws IllegalAccessException, InvocationTargetException, SQLException{
			Connection conn = DBPool.getConnection();
			entity.setUpdate_date(DBUtility.getDBCurrentDateTime());
			entity.setUpdate_by(entity.getCreate_by());
			DBUtility.updateToDB(conn, tableName, entity, new String[]{"cat_name_short","cat_name_th","update_by","update_date"}, new String[]{"cat_id","group_id"});
			conn.close();
		}
		
		public static boolean checkShortName(PartCategories entity) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			boolean pass = false;
			Connection conn = DBPool.getConnection();
			pass = DBUtility.getEntityFromDB(conn, tableName, entity, new String[]{"cat_name_short","group_id"});
			conn.close();
			return pass;
		}
		
		public  static boolean checkName(String cat_name_th,String cat_name_short ,String group_id) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			PartCategories entity = new PartCategories();
			entity.setCat_name_th(cat_name_th);
			entity.setcat_name_short(cat_name_short);
			entity.setGroup_id(group_id);
			return checkName(entity);
		}
		public  static boolean checkName(PartCategories entity) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			Connection conn = DBPool.getConnection();
			boolean check = false;
			//System.out.println(entity.getCat_name_th()+" : "+entity.getcat_name_short()+" : "+entity.getGroup_id());
			check = DBUtility.getEntityFromDB(conn, tableName, entity, new String[]{"cat_name_th","cat_name_short","group_id"});
			conn.close();
			//System.out.println(check);
			return check;
		}
		public static PartCategories  selectcheckName(String cat_id ,String group_id ,String cat_name_th, String cat_name_short) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			PartCategories entity = new PartCategories();
			entity.setCat_id(cat_id);
			entity.setGroup_id(group_id);
			entity.setCat_name_th(cat_name_th);
			entity.setcat_name_short(cat_name_short);
			return selectcheckName(entity);
		}
		
		public static PartCategories selectcheckName(PartCategories entity) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			Connection conn = DBPool.getConnection();
			DBUtility.getEntityFromDB(conn, tableName, entity, new String[]{"cat_id","group_id","cat_name_th","cat_name_short"});
			conn.close();
			return entity;
			
		}
		
		public static PartCategories  selectcheckName_th(String cat_id ,String group_id ,String cat_name_th) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			PartCategories entity = new PartCategories();
			entity.setCat_id(cat_id);
			entity.setGroup_id(group_id);
			entity.setCat_name_th(cat_name_th);
			return selectcheckName_th(entity);
		}
		
		public static PartCategories selectcheckName_th(PartCategories entity) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			Connection conn = DBPool.getConnection();
			DBUtility.getEntityFromDB(conn, tableName, entity, new String[]{"cat_id","group_id","cat_name_th"});
			conn.close();
			return entity;
			
		}
		
		public static PartCategories  selectcheckNameShort(String cat_id ,String group_id ,String cat_name_short) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			PartCategories entity = new PartCategories();
			entity.setCat_id(cat_id);
			entity.setGroup_id(group_id);
			entity.setcat_name_short(cat_name_short);
			return selectcheckNameShort(entity);
		}
		
		public static PartCategories selectcheckNameShort(PartCategories entity) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			//////System.out.println("cat_id"+entity.getCat_id()+"group_id:"+entity.getGroup_id()+"name"+entity.getCat_name_th());
			
			Connection conn = DBPool.getConnection();
			DBUtility.getEntityFromDB(conn, tableName, entity, new String[]{"cat_id","group_id","cat_name_short"});
			conn.close();
			return entity;
			
		}
		
		
		public static boolean checkName_th(PartCategories entity) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			boolean pass = false;
			Connection conn = DBPool.getConnection();
			pass = DBUtility.getEntityFromDB(conn, tableName, entity, new String[]{"cat_name_th","group_id"});
			conn.close();
			return pass;
		}
		
		public static boolean checkName_short(PartCategories entity) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			boolean pass = false;
			Connection conn = DBPool.getConnection();
			pass = DBUtility.getEntityFromDB(conn, tableName, entity, new String[]{"cat_name_short","group_id"});
			conn.close();
			return pass;
		}
		
		
		public static boolean checkShortNameForEdit(PartCategories entity) throws IllegalArgumentException, SQLException, IllegalAccessException, InvocationTargetException{
			boolean pass = false;
			String sql = "SELECT * FROM " + tableName + " WHERE cat_id!='" + entity.getCat_id() + "' AND cat_name_short='" + entity.cat_name_short + "' AND group_id='"+entity.getGroup_id()+"'";
			Connection conn = DBPool.getConnection();
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);			
			pass = rs.next();
			rs.close();
			st.close();
			conn.close();
			return pass;
		}
		//bas
		public static String  SelectCat_name(String cat_id , String group_id) throws UnsupportedEncodingException, SQLException, IllegalAccessException, InvocationTargetException{
			String sql = "SELECT cat_name_th as cnt FROM " + tableName + " WHERE group_id ='" + group_id + "' AND cat_id= '"+cat_id+"' ORDER BY (cat_id*1)";
			Connection conn = DBPool.getConnection();
			Statement st = conn.createStatement();
			ResultSet rs = st.executeQuery(sql);
			
			String cnt = "";
			while (rs.next()) {
				cnt = DBUtility.getString("cnt", rs);
			}
			rs.close();
			st.close();
			conn.close();
			return cnt;
		}
		
		
		public String getCat_id() {
			return cat_id;
		}
		public void setCat_id(String cat_id) {
			this.cat_id = cat_id;
		}
		public String getGroup_id() {
			return group_id;
		}
		public void setGroup_id(String group_id) {
			this.group_id = group_id;
		}
		public String getcat_name_short() {
			return cat_name_short;
		}
		public void setcat_name_short(String cat_name_short) {
			this.cat_name_short = cat_name_short;
		}
		public String getCat_name_th() {
			return cat_name_th;
		}
		public void setCat_name_th(String cat_name_th) {
			this.cat_name_th = cat_name_th;
		}
		public String getCreate_by() {
			return create_by;
		}
		public void setCreate_by(String create_by) {
			this.create_by = create_by;
		}
		public Timestamp getCreate_date() {
			return create_date;
		}
		public void setCreate_date(Timestamp create_date) {
			this.create_date = create_date;
		}
		public String getUpdate_by() {
			return update_by;
		}
		public void setUpdate_by(String update_by) {
			this.update_by = update_by;
		}
		public Timestamp getUpdate_date() {
			return update_date;
		}
		public void setUpdate_date(Timestamp update_date) {
			this.update_date = update_date;
		}
		
		
	}