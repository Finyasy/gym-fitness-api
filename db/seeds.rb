# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Seeding database for Extreme Fitness Centre..."

# Create Admin User
admin = Admin.find_or_create_by!(email: 'Omusotsifredrick24@gmail.com') do |a|
  a.name = 'Fredrick Omusotsi'
  a.password = 'admin123'  # Change this password after first login
  a.password_confirmation = 'admin123'
end
puts "✓ Admin created: #{admin.email}"

# Create Sample Members
members_data = [
  { name: 'John Doe', email: 'john@example.com', phone: '+1234567890', membership_type: 'Monthly', join_date: Date.today - 30.days, status: 'active' },
  { name: 'Jane Smith', email: 'jane@example.com', phone: '+1234567891', membership_type: 'Quarterly', join_date: Date.today - 60.days, status: 'active' },
  { name: 'Mike Johnson', email: 'mike@example.com', phone: '+1234567892', membership_type: 'Annual', join_date: Date.today - 90.days, status: 'active' }
]

members_data.each do |member_data|
  Member.find_or_create_by!(email: member_data[:email]) do |m|
    m.name = member_data[:name]
    m.phone = member_data[:phone]
    m.membership_type = member_data[:membership_type]
    m.join_date = member_data[:join_date]
    m.status = member_data[:status]
  end
end
puts "✓ Sample members created"

# Create Sample Payments
Member.all.each do |member|
  Payment.find_or_create_by!(member: member, payment_date: Date.today) do |p|
    p.amount = case member.membership_type
               when 'Monthly' then 50.00
               when 'Quarterly' then 135.00
               when 'Annual' then 480.00
               else 50.00
               end
    p.payment_method = 'Credit Card'
    p.status = 'completed'
    p.notes = 'Initial membership payment'
  end
end
puts "✓ Sample payments created"

# Create Weekly Schedule - Extreme Fitness Workout Program
schedule_data = [
  # MONDAY - Push Day (Chest/Shoulders/Triceps)
  { day: 'Monday', time_slot: 'Push Day', activity: 'Chest/Shoulders/Triceps - Bench Press 4x8, Overhead Dumbbell Press 3x10, Incline Dumbbell Press 3x10, Lateral Raises 3x12-15, Triceps Dips or Rope Pushdowns 3x12', trainer: 'Aerobics - Cardio - Boxing', capacity: 30 },

  # TUESDAY - Pull Day (Back/Biceps)
  { day: 'Tuesday', time_slot: 'Full Day', activity: 'Back/Biceps - Pull-Ups or Lat Pulldowns 4x8-10, Barbell or Dumbbell Rows 4x10, Face Pulls 3x12, Barbell or Dumbbell Curls 3x12, Hammer Curls 3x10', trainer: 'Karate - Cardio - Boxing', capacity: 30 },

  # WEDNESDAY - Leg Day + Core
  { day: 'Wednesday', time_slot: 'Leg Day + Core', activity: 'Barbell Squats 4x8, Romanian Deadlifts 3x10, Walking Lunges 3x20, Seated Calf Raises 3x15, Planks 3 sets x 60 seconds, Hanging Leg Raises 3x15', trainer: 'Aerobics - Cardio - Boxing', capacity: 30 },

  # THURSDAY - Active Recovery / Light Cardio
  { day: 'Thursday', time_slot: 'Active Recovery', activity: 'Light Cardio - 20-30 mins cycling, brisk walking, or swimming, Foam rolling or yoga/mobility drills', trainer: 'Karate - Cardio - Boxing', capacity: 30 },

  # FRIDAY - Upper Body Strength
  { day: 'Friday', time_slot: 'Upper Body Strength', activity: 'Incline Bench Press 4x8, Pull-Ups 4xMax, Arnold Press 3x8, Pendlay Rows 3x8, Barbell Curls + Skull Crushers 3x10 each', trainer: 'Aerobics - Cardio - Boxing', capacity: 30 },

  # SATURDAY - Run, Glutes & Legs Focus
  { day: 'Saturday', time_slot: 'Run, Glutes & Legs', activity: 'Hip Thrusts 4x10, Bulgarian Split Squats 3x10 per leg, Sumo Deadlifts 3x6-8, Glute Kickbacks 3x12, Cable Abductions 3x15 per side', trainer: 'Aerobics - Cardio - Boxing', capacity: 30 },

  # SUNDAY - Rest Day
  { day: 'Sunday', time_slot: 'Rest Day', activity: 'Complete rest or light stretching and recovery', trainer: 'Rest & Recovery', capacity: 0 }
]

schedule_data.each do |schedule|
  Schedule.find_or_create_by!(day: schedule[:day], time_slot: schedule[:time_slot]) do |s|
    s.activity = schedule[:activity]
    s.trainer = schedule[:trainer]
    s.capacity = schedule[:capacity]
  end
end
puts "✓ Weekly schedule created"

puts "\n🎉 Seeding complete!"
puts "Admin Login: Omusotsifredrick24@gmail.com / admin123"
