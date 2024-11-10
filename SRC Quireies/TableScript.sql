

CREATE TABLE Learner (
    Learner_ID INT PRIMARY KEY,
    name VARCHAR(50),
    birthday DATE,
   
    gender VARCHAR(10),
    country VARCHAR(50)
    
);

CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    title VARCHAR(100),
    description VARCHAR(255),
    diff_level VARCHAR(8),
    credit_point INT,
    instructor_ID INT
    --FOREIGN KEY (instructor_ID) REFERENCES Instructor(ID)
);