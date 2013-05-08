#!/usr/bin/env ruby
require 'sinatra'


# My class for holding the ToDo's
class Todo
	@@total = 0
	attr_accessor :text
	attr_accessor :done
	attr_accessor :id
	def initialize(text = "No description", done = false)
		@text = text
		@done = done
		@id = @@total
		@@total = @@total + 1
	end
end
# The list that holds the ToDo's
todoList = Array.new
#Main Page
get '/' do
	@todos = todoList
	erb :menu
end
#Handles new todo's
post '/' do
	newTodo = Todo.new(params[:note])
	todoList.push(newTodo)
	redirect '/'
end
#Handles editing a todo
post '/edit/:id' do
	todoList.each do |todo|
		if todo.id == params[:id].to_i
			todo.text = params[:edit]
		end
	end
	redirect '/'
end
#Handles status changes for a todo
post '/status/:id' do
	todoList.each do |todo|
		if todo.id == params[:id].to_i
			if todo.done
				todo.done = false
			else
				todo.done = true
			end
		end
	end
	redirect '/'
end
#Handles deleting a todo
post '/delete/:id' do
	todoList.each do |todo|
		if todo.id == params[:id].to_i
			todoList.delete(todo)
		end
	end
	redirect '/'
end


	