function Student(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
}

Student.prototype.name = function() {
  return `${this.firstName} ${this.lastName}`;
};

Student.prototype.courses = [];

Student.prototype.enroll = function(course) {
  if (!this.courses.includes(course)) {
    this.courses.forEach(function(stuCourse) {
      if (stuCourse.conflictsWith(course)) { throw "Conflicting times"; }
    });
    this.courses.push(course);
    course.addStudent(this);
  }
};

Student.prototype.courseLoad = function() {
  let courseLoad = {};
  this.courses.forEach(function(course) {
    if (courseLoad[`${course.department}`]) {
      courseLoad[`${course.department}`] += course.credits;
    } else {
      courseLoad[`${course.department}`] = course.credits;
    }
  });
  return courseLoad;
};

function Course(name, department, numCredits, days, timeBlock) {
  this.name = name;
  this.department = department;
  this.credits = numCredits;
  this.days = days;
  this.time = timeBlock;
}

Course.prototype.students = [];

Course.prototype.addStudent = function(student) {
  this.students.push(student);
};

Course.prototype.conflictsWith = function(course) {
  this.days.forEach(function(day) {
    if (course.days.includes(day) && course.time === this.time) {
      return true;
    }
  });
  return false;
};
