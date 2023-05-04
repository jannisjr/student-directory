require 'csv'

@default_filename = "students.csv"

@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv" 
  puts "9. Exit"
end

def interactive_menu
  loop do
   print_menu
   process(STDIN.gets.chomp)
  end
end

def process(selection)
  puts "You have selected option #{selection}"
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

def input_students
  puts "Please enter the name of the student"
  puts "To finish, just hit return twice"
  name = STDIN.gets.delete("\n").capitalize
  while !name.empty? do
    puts "What cohort month are they in?"
    cohort = STDIN.gets.chomp.capitalize
    if cohort.empty?
      cohort = "November"
    else
      until spelling(cohort) == true
        puts "Please check the spelling of the month and try again"
        cohort = STDIN.gets.chomp.capitalize
      end
    end
    add_student(name, cohort)
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
    puts "Please enter the name of the student"
    puts "To finish, just hit return twice"
    name = STDIN.gets.chomp.capitalize
  end
end

def show_students
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
    @students.each.with_index(1) do |student,index|
      puts "#{index} #{student[:name]} (#{student[:cohort]} cohort)"
  end
end
# The same method using loops
def print_loop
  until @students.empty?
    name = @students.pop
    puts "#{name[:name]} #{name[:cohort]} cohort"
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


def save_students (filename = @filename)
  CSV.open(filename, "w") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  end
  puts "Saved to #{filename}"
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def load_students(filename = @filename)
  puts "Would you like to load a file other than the default? y/n"
  response = STDIN.gets.chomp
  if response == "y"
    puts "Please name the file you would like to load"
    filename = STDIN.gets.chomp
  else
    filename = "students.csv"
  end
  if File.exist?(filename)
    CSV.foreach(filename) do |row|
      name, cohort = row
      add_student(name, cohort) 
  end 
    @filename = filename
    puts "#{filename} loaded successfully"
  end
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    puts "Loaded the default file: students.csv"
    load_students(@filename)
  elsif File.exist?(filename)
    @filename = filename
    load_students(@filename)
     puts "Loaded #{@students.count} from #{@filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
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

try_load_students
interactive_menu