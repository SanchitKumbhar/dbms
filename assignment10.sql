-- // Step 1: Use database
use school

-- // Step 2: Insert sample data
db.students.insertMany([
  { name: "Yash", class: 10, subject: "Maths", marks: 85 },
  { name: "Neha", class: 10, subject: "Science", marks: 78 },
  { name: "Riya", class: 9, subject: "Maths", marks: 90 },
  { name: "Aarav", class: 10, subject: "Maths", marks: 92 },
  { name: "Meera", class: 9, subject: "Science", marks: 70 },
  { name: "Anjali", class: 10, subject: "Science", marks: 88 }
])

-- // Step 3: MapReduce to calculate total marks per class
db.students.mapReduce(
--   // Map function: emit class as key and marks as value
  function() { emit(this.class, this.marks); },

--   // Reduce function: sum all marks for each class
  function(key, values) { return Array.sum(values); },

--   // Output collection
  { out: "class_total_marks" }
)

-- // Step 4: Display total marks per class
db.class_total_marks.find().pretty()

-- // Step 5: MapReduce to calculate average marks per class
db.students.mapReduce(
  function() { emit(this.class, this.marks); },
  function(key, values) { return { total: Array.sum(values), count: values.length }; },
  {
    out: "class_avg_marks",
    finalize: function(key, reducedValue) {
      reducedValue.avg = reducedValue.total / reducedValue.count;
      return reducedValue;
    }
  }
)

-- // Step 6: Display average marks per class
db.class_avg_marks.find().pretty()
