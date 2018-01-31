package com.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.model.TaskVO;
@Repository
public class ToDoDAO {
	@Autowired 
	JdbcTemplate jdbcTemplate;
   public static int counter=0;
   public TaskVO[] getAllRows(){
	   
	    List<TaskVO> tasks = this.jdbcTemplate.query("select * from Tasks", new RowMapper<TaskVO>() {

		public TaskVO mapRow(ResultSet arg0, int arg1) throws SQLException {
			TaskVO taskVO = new TaskVO();
			taskVO.setTaskId(Integer.parseInt(arg0.getString("taskId"))); 
			taskVO.setTodoText(arg0.getString("todoText"));
			taskVO.setDone((arg0.getString("done").equals("Y"))?true:false);
            return taskVO;
		}
	}); 
	   return tasks.toArray(new TaskVO[tasks.size()]);
   }
   
   public TaskVO inserttask(TaskVO taskVO){
	   taskVO.setTaskId(++counter);
	   String query = "insert into Tasks (taskId,todoText,done) values (?,?,?)";
	   Object[] inputs = new Object[] {taskVO.getTaskId(), taskVO.getTodoText(), "N"};
	   jdbcTemplate.update(query, inputs);
	   return taskVO;
   }
   
   public void complete( TaskVO [] tasks){ 
	   StringBuilder inclause=new StringBuilder("(");
	   for(int i=0;i<tasks.length;i++){
		   inclause.append(tasks[i].getTaskId()+",");
	   }
	   inclause.replace(inclause.length()-1, inclause.length(), ")");
	   String query = "update Tasks set done ='Y' where taskId in "+inclause.toString();
	   jdbcTemplate.update(query);
   }
   
   public void delete( TaskVO [] tasks){ 
	   StringBuilder inclause=new StringBuilder("(");
	   for(int i=0;i<tasks.length;i++){
		   inclause.append(tasks[i].getTaskId()+",");
	   }
	   inclause.replace(inclause.length()-1, inclause.length(), ")");
	   String query = "delete from Tasks where taskId in "+inclause.toString();
	   jdbcTemplate.update(query);
   }
   
}
