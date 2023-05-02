students = [
 {name: "Dr. Hannibal Lecter", cohort: :november} ,
 {name: "Darth Vader", cohort: :november} ,
 {name: "Nurse Ratched", cohort: :november,} ,
 {name: "Michael Corleone", cohort: :november} ,
 {name: "Alex DeLarge", cohort: :november} ,
 {name: "The Wicked Witch of the West", cohort: :november} ,
 {name: "Terminator", cohort: :november} ,
 {name: "Freddy Krueger", cohort: :november} ,
 {name: "The Joker", cohort: :november} ,
 {name: "Joffrey Baratheon", cohort: :november} ,
 {name: "Norman Bates", cohort: :november} ,
]
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  student = []
  name = gets.chomp
  while !name.empty? do
    puts "Please enter the student's country of birth"
    country = gets.chomp
    puts "Please enter the student's hobbies"
    hobbies = gets.chomp
    puts "Please enter the student's height in metres and centimetres"
    height = gets.chomp
    student << {name: name, country: country, hobbies: hobbies, height: height, cohort: :november}
    puts "Now we have #{student.count} students"
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
    name = gets.chomp
  end
  student
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
    students.each.with_index(1) do |student,index|
      puts "#{index} #{student[:name]} #{student[:country]} #{student[:hobbies]}
      #{student[:height]} (#{student[:cohort]} cohort)"
  end
end
# The same method using loops
def print_loop(students)
  until students.empty?
    name = students.pop
    puts "#{name[:name]} #{name[:country]} #{name[:hobbies]}
    #{name[:height]}#{name[:cohort]} cohort"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end
def letter_sort(students)
  students.each do |student|
    if student[:name].start_with?("N")
      puts student
    end
  end
end
def name_length(students)
  students.each do |student|
    if student[:name].length < 12
      puts student
    end
  end
end
students = input_students
if students.empty?
  puts "No students found"
end
print_header
print(students)
puts ""
puts "names under 12 characters"
name_length(students)
puts ""
puts "names starting with N"
letter_sort(students)
print_footer(students)