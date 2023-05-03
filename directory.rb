@students = []

def input_students
  puts "Please enter the name of the student"
  puts "To finish, just hit return twice"
  name = gets.delete("\n").capitalize
  while !name.empty? do
    puts "Please enter the student's country of birth"
    country = gets.chomp.capitalize
    puts "Please enter the student's hobbies"
    hobbies = gets.chomp
    puts "Please enter the student's height in metres and centimetres"
    height = gets.chomp
    puts "What cohort month are they in?"
    month = gets.chomp.capitalize
    if month.empty?
      month = "November"
    else
      until spelling(month) == true
        puts "Please check the spelling of the month and try again"
        month = gets.chomp.capitalize
      end
    end
    @students << {name: name, country: country, hobbies: hobbies, height: height, cohort: month.to_sym}
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
    puts "Please enter the name of the student"
    puts "To finish, just hit return twice"
    name = gets.chomp.capitalize
  end
end

def interactive_menu
  loop do
   print_menu
   process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "9"
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

def spelling(month)
  month_array = [ 
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ]
  month_array.include?(month)
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
    @students.each.with_index(1) do |student,index|
      puts "#{index} #{student[:name].center(16)} #{student[:country].center(15)} #{student[:hobbies].center(15)} #{student[:height].center(15)} (#{student[:cohort]} cohort)"
  end
end
# The same method using loops
def print_loop
  until @students.empty?
    name = @students.pop
    puts "#{name[:name]} #{name[:country]} #{name[:hobbies]}
    #{name[:height]}#{name[:cohort]} cohort"
  end
end

def print_footer
  if @students.count == 1
    puts "Now we have #{@students.count} student"
  else
    puts "Now we have #{@students.count} students"
  end
end

def letter_sort
  @students.each do |student|
    if student[:name].start_with?("N")
      puts student
    end
  end
end

def name_length
  @students.each do |student|
    if student[:name].length < 12
      puts student
    end
  end
end

def group_by_cohort
  cohorts_hash = {}
  puts "Cohort Groups"
  @students.each do |student|
    cohort = student[:cohort]
    name = student[:name]
    if cohorts_hash[cohort] == nil
      cohorts_hash[cohort] = [name]
    else
      cohorts_hash[cohort].push(name)
    end
  end
  cohorts_hash.each do |key, value|
    puts "Cohort #{key}"
    puts value
  end
end

interactive_menu