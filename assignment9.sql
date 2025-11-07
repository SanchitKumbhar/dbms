 use school
db.students.insertMany([
  { _id: 1, name: "Yash", class: 10, marks: 85, age: 15 },
  { _id: 2, name: "Neha", class: 10, marks: 78, age: 16 },
  { _id: 3, name: "Riya", class: 9, marks: 90, age: 14 },
  { _id: 4, name: "Aarav", class: 10, marks: 92, age: 16 },
  { _id: 5, name: "Meera", class: 9, marks: 70, age: 15 },
  { _id: 6, name: "Anjali", class: 10, marks: 88, age: 15 }
])

db.students.aggregate([
  { $group: { _id: "$class", avgMarks: { $avg: "$marks" }, totalStudents: { $sum: 1 } } }
])

db.students.createIndex({ name: 1 })
