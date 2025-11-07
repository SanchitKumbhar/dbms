-- Write 5 query using mongodb

-- // Step 1: Create or switch to database
use school

-- // Step 2: Insert sample data into 'students' collection
db.students.insertMany([
  { _id: 1, name: "Yash", class: 10, marks: 85, age: 15 },
  { _id: 2, name: "Neha", class: 10, marks: 78, age: 15 },
  { _id: 3, name: "Riya", class: 9, marks: 90, age: 14 },
  { _id: 4, name: "Aarav", class: 10, marks: 92, age: 16 },
  { _id: 5, name: "Meera", class: 9, marks: 70, age: 15 },
  { _id: 6, name: "Anjali", class: 10, marks: 88, age: 15 }
])

-- // Step 3: Find all students in class 10 with marks > 80
db.students.find({ class: 10, marks: { $gt: 80 } }).pretty()

-- // Step 4: Update Neha's age to 16
db.students.updateOne({ name: "Neha" }, { $set: { age: 16 } })
db.students.find({ name: "Neha" }).pretty()

-- // Step 5: Delete students with marks < 75
db.students.deleteMany({ marks: { $lt: 75 } })
db.students.find().pretty()

-- // Step 6: Count number of students in each class
db.students.aggregate([
  { $group: { _id: "$class", totalStudents: { $sum: 1 } } }
])

-- // Step 7: Find students whose name contains 'a'
db.students.find({ name: /a/i }).pretty()
