require 'pry'

class Student
  
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # create a new Student object given a row from the database
    student = self.new
    student.id = row[0]
    student.name = row[1]
    student.grade = row[2]
    student
  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
    sql = <<-SQL
    SELECT * 
    FROM students 
    SQL
    DB[:conn].execute(sql).collect do |row|
      self.new_from_db(row)
    end
  end

  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
    sql = <<-SQL
    SELECT * 
    FROM students
    WHERE name = ?
    LIMIT 1
    SQL
    DB[:conn].execute(sql,name).map do |row|
      self.new_from_db(row)
    end.first
  end

  def self.students_below_12th_grade
    sql = <<-SQL
    SELECT * 
    FROM students 
    WHERE students.grade < 12
    SQL
    DB[:conn].execute(sql).collect do |row|
      self.new_from_db(row)
    end
  end

  def self.first_student_in_grade_10
    sql = <<-SQL
    SELECT * 
    FROM students
    WHERE students.grade = 10
    LIMIT 1
    SQL
    DB[:conn].execute(sql).collect do |row|
      self.new_from_db(row)
    end.first
  end

def self.count_all_students_in_grade_9
  sql = <<-SQL
  SELECT *
  FROM students
  WHERE students.grade = 9
  SQL
  DB[:conn].execute(sql).collect do |row|
    self.new_from_db(row)
  end
end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 