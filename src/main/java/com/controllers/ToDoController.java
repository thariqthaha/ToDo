package com.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dao.ToDoDAO;
import com.model.TaskVO;

@Controller
public class ToDoController {
     @Autowired
	ToDoDAO toDoDAO;
	
	@RequestMapping("/list")
	public ModelAndView testMethod(){
		System.out.println("********Inside");
		return new ModelAndView("ToDo", "message", "blah");
	}
	
	
	@RequestMapping(method=RequestMethod.GET,value="/fromDb",headers={"Accept=application/json"})
	public @ResponseBody TaskVO [] getTasks(){
		System.out.println("********Inside get"+toDoDAO.getAllRows()[0].getTodoText());
		return toDoDAO.getAllRows();
	}
	
	@RequestMapping(method=RequestMethod.POST,value="/fromDb",headers={"Content-Type=application/json"})
	public @ResponseBody TaskVO postTask(@RequestBody TaskVO task){
		System.out.println("********Inside post"+task.getTodoText());
		task=toDoDAO.inserttask(task);
		return task;
	}
	
	@RequestMapping(method=RequestMethod.PUT,value="/fromDb",headers={"Content-Type=application/json"})
	public @ResponseBody String putTask(@RequestBody TaskVO [] taskArr){
		System.out.println(taskArr[0].getTodoText());
		toDoDAO.complete(taskArr);
		return null;
	}
	
	@RequestMapping(method=RequestMethod.DELETE,value="/fromDb",headers={"Content-Type=application/json"})
	public @ResponseBody String deleteTask(@RequestBody TaskVO [] taskArr){
		toDoDAO.delete(taskArr);
		return null;
	}
}
