package com.model;

public class TaskVO {

	int taskId;
	String todoText;
	boolean done;
	public int getTaskId() {
		return taskId;
	}
	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}
	public String getTodoText() {
		return todoText;
	}
	public void setTodoText(String todoText) {
		this.todoText = todoText;
	}
	public boolean isDone() {
		return done;
	}
	public void setDone(boolean done) {
		this.done = done;
	}
	
	
	
}
