-- Create the department table
CREATE TABLE department (
  dept_name VARCHAR(20),
  building VARCHAR(15),
  budget NUMERIC(12, 2) CHECK (budget > 0),
  PRIMARY KEY (dept_name)
);

-- Create the course table
CREATE TABLE course (
  course_id VARCHAR(8),
  title VARCHAR(50),
  dept_name VARCHAR(20),
  credits NUMERIC(2, 0) CHECK (credits > 0),
  PRIMARY KEY (course_id),
  FOREIGN KEY (dept_name) REFERENCES department (dept_name) ON DELETE SET NULL
);

-- Create the instructor table
CREATE TABLE instructor (
  ID VARCHAR(5),
  name VARCHAR(20) NOT NULL,
  dept_name VARCHAR(20),
  salary NUMERIC(10, 2),
  PRIMARY KEY (ID),
  FOREIGN KEY (dept_name) REFERENCES department (dept_name) ON DELETE SET NULL
);

-- Create the section table
CREATE TABLE section (
  course_id VARCHAR(8),
  sec_id VARCHAR(8),
  semester NUMERIC(1, 0) ,
  Year NUMERIC(1, 0),
  building VARCHAR(5),
  room_number VARCHAR(5),
  time_slot_id VARCHAR(12),
  PRIMARY KEY (course_id, sec_id, semester, Year),
  FOREIGN KEY (course_id) REFERENCES course (course_id) ON DELETE CASCADE
);

-- Create the teaches table
CREATE TABLE teaches (
  ID VARCHAR(5),
  course_id VARCHAR(8),
  sec_id VARCHAR(8),
  semester NUMERIC(1, 0),
  Year NUMERIC(1, 0),
  PRIMARY KEY (ID, course_id, sec_id, semester, Year),
  FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section (course_id, sec_id, semester, year) ON DELETE CASCADE,
  FOREIGN KEY (ID) REFERENCES instructor (ID) ON DELETE CASCADE
);

-- Create the student table
CREATE TABLE student (
  ID VARCHAR(5),
  name VARCHAR(20) NOT NULL,
  dept_name VARCHAR(20),
  tot_cred NUMERIC(3, 0) CHECK (tot_cred >= 0),
  PRIMARY KEY (ID),
  FOREIGN KEY (dept_name) REFERENCES department (dept_name) ON DELETE SET NULL
);

-- Create the takes table
CREATE TABLE takes (
  ID VARCHAR(5),
  course_id VARCHAR(8),
  sec_id VARCHAR(5),
  semester NUMERIC(1, 0),
  Year NUMERIC(1, 0),
  grade VARCHAR(2),
  PRIMARY KEY (ID, course_id, sec_id, semester, Year),
  FOREIGN KEY (course_id, sec_id, semester, Year) REFERENCES section (course_id, sec_id, semester, Year) ON DELETE CASCADE,
  FOREIGN KEY (ID) REFERENCES student (ID) ON DELETE CASCADE
);

-- Create the advisor table
CREATE TABLE advisor (
  s_ID VARCHAR(5),
  i_ID VARCHAR(5),
  PRIMARY KEY (s_ID),
  FOREIGN KEY (i_ID) REFERENCES instructor (ID) ON DELETE SET NULL,
  FOREIGN KEY (s_ID) REFERENCES student (ID) ON DELETE CASCADE
);
