

CREATE TABLE Learner (
    Learner_ID INT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    birthday DATE,
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female')),
    country VARCHAR(20),
    cultural_background VARCHAR(50)   
);
CREATE TABLE Skills(
FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID),
skill VARCHAR(50)

);

CREATE TABLE LearningPrefrences(
FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID),
prefrences VARCHAR(50)

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