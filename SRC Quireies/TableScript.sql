
CREATE DATABASE EduPlatform
use EduPlatform

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
FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID)ON DELETE CASCADE ON UPDATE CASCADE,
skill VARCHAR(50)

);

CREATE TABLE LearningPrefrences(
FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID) ON DELETE CASCADE ON UPDATE CASCADE,
prefrences VARCHAR(50)

);

CREATE TABLE PersonalProfile(

FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID) ON DELETE CASCADE ON UPDATE CASCADE,
profileID INT PRIMARY KEY,
PreferedContent_type VARCHAR(50),
emotionalState VARCHAR(50),
personality_type VARCHAR(50)

);
CREATE TABLE HealthCondition(
FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (profileID) REFERENCES PersonalProfile(profileID) ON DELETE CASCADE ON UPDATE CASCADE,
condition VARCHAR(50)

);
CREATE TABLE Course (
    Course_ID INT PRIMARY KEY,
    title VARCHAR(100),
    description VARCHAR(255),
    diff_level VARCHAR(8),
    credit_point INT,
   learning_objective VARCHAR(255),
   pre_requisites VARCHAR(255)
   
);
CREATE TABLE Module (
	Module_ID INT PRIMARY KEY,
	FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON DELETE CASCADE ON UPDATE CASCADE,
	title VARCHAR(100),
	difficulty_level VARCHAR(8),
    contentURL VARCHAR(255)	
);

CREATE TABLE TargetTraits(
FOREIGN KEY (Module_ID) REFERENCES Module(Module_ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON DELETE CASCADE ON UPDATE CASCADE,
trait VARCHAR(50)


);

CREATE TABLE ModuleContent(
FOREIGN KEY (Module_ID) REFERENCES Module(Module_ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON DELETE CASCADE ON UPDATE CASCADE,
contetntType VARCHAR(50)

);

CREATE TABLE ContentLibrary(
Lib_ID INT PRIMARY KEY,
FOREIGN KEY (Module_ID) REFERENCES Module(Module_ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON DELETE CASCADE ON UPDATE CASCADE,
title VARCHAR(100),
description VARCHAR(255),
metaData VARCHAR(255),
type VARCHAR(50),
contentURL VARCHAR(255)
);

CREATE TABLE Course_Enrollment(
Enrollment_ID INT PRIMARY KEY,
FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON DELETE CASCADE ON UPDATE CASCADE,
enrollment_date DATE,
completion_date DATE,
status VARCHAR(50) CHECK (status IN ('Completed', 'In Progress', 'Not Started'))
);

CREATE TABLE Assessment (
	Assessment_ID INT PRIMARY KEY,
	FOREIGN KEY (Module_ID) REFERENCES Module(Module_ID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON DELETE CASCADE ON UPDATE CASCADE,
	type VARCHAR(50),
    totalMarks INT,
    passingMarks INT,
    criteria VARCHAR(255),
    weightage INT,
    description VARCHAR(255),
    title VARCHAR(100)
);

CREATE TABLE Instructor (
	Instructor_ID INT PRIMARY KEY,
	Instructor_name VARCHAR(20),
	latest_qualification VARCHAR(20),
    expertise_area VARCHAR(50),
    email VARCHAR(50)

    );
    CREATE TABLE pathreview(
    FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Path_ID) REFERENCES LearningPath(Path_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    feedback VARCHAR(255)
    );
CREATE TABLE Emotionalfeedback_review (
    FeedbackID INT,
    InstructorID INT,
    feedback VARCHAR(500),
    PRIMARY KEY (FeedbackID, InstructorID),
    FOREIGN KEY (FeedbackID) REFERENCES Emotional_feedback(FeedbackID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (InstructorID) REFERENCES Instructor(Instructor_ID) ON DELETE CASCADE ON UPDATE CASCADE
);
    CREATE TABLE Teaches(
    FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON DELETE CASCADE ON UPDATE CASCADE
	);

    CREATE TABLE learningActivity(
    Activity_ID INT PRIMARY KEY,
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Module_ID) REFERENCES Module(Module_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    activityType VARCHAR(50),
    instruction_details VARCHAR(255),
    maxScore INT
    );

    CREATE TABLE LearningPath(        
    Path_ID INT PRIMARY KEY,
    FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (profileID) REFERENCES PersonalProfile(profileID) ON DELETE CASCADE ON UPDATE CASCADE,
    completion_status VARCHAR(220),
    customContent VARCHAR(255),
    adaptiveRules VARCHAR(255)
    );
    CREATE TABLE Notification(
    Notification_ID INT PRIMARY KEY,
    time_stamp TIMESTAMP,
    message VARCHAR(255),
    urgency VARCHAR(50) CHECK (urgency IN ('High', 'Medium', 'Low'))
    );
    Create TABLE RecivedNotfy(
    FOREIGN KEY (Learner_ID) REFERENCES Learner(Learner_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Notification_ID) REFERENCES Notification(Notification_ID) ON DELETE CASCADE ON UPDATE CASCADE
	);
    CREATE TABLE Reward(
    RewardID INT PRIMARY KEY,
    value INT,
    description VARCHAR(200),
    type VARCHAR(50)
);

    CREATE TABLE Emotional_feedback(
    FeedbackID INT PRIMARY KEY,
    LearnerID INT ,
    timestamp DATETIME,
    emotional_state VARCHAR(20) CHECK (emotional_state in (
            'Admiration', 'Adoration', 'Aesthetic Appreciation', 'Amusement', 
            'Anger', 'Anxiety', 'Awe', 'Awkwardness', 'Boredom', 'Calmness', 
            'Confusion', 'Craving', 'Disgust', 'Empathetic Pain', 'Entrancement', 
            'Excitement', 'Fear', 'Horror', 'Interest', 'Joy', 
            'Nostalgia', 'Relief', 'Romance', 'Sadness', 'Satisfaction', 
            'Surprise'
        ))
        FOREIGN KEY(LearnerID) REFERENCES Learner(Learner_ID) ON DELETE CASCADE ON UPDATE CASCADE,
);
 CREATE TABLE Emotionalfeedback_review (
    FeedbackID INT,
    InstructorID INT,
    feedback VARCHAR(500),
    PRIMARY KEY (FeedbackID, InstructorID),
    FOREIGN KEY (FeedbackID) REFERENCES Emotional_feedback(FeedbackID),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);
CREATE TABLE Interaction_log (
    LogID INT PRIMARY KEY,
    activity_ID INT,
    LearnerID INT,
    Duration TIME,
    Timestamp DATETIME ,
    action_type VARCHAR(50),
    FOREIGN KEY (activity_ID) REFERENCES learningActivity(Activity_ID) ON DELETE CASCADE ON UPDATE CASCADE
    )

 CREATE table Quest(
QuestID INT PRIMARY KEY,
difficulty_level int,
criteria VARCHAR(50),
description VARCHAR(200),
title VARCHAR(60)
);


CREATE TABLE QuestReward(
	QuestID INT,
	RewardID INT,
    LearnerID INT,
    PRIMARY KEY (QuestID, RewardID,LearnerID),
    timeEarned TIMESTAMP,
	FOREIGN KEY (QuestID) REFERENCES Quest(QuestID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (RewardID) REFERENCES Reward(RewardID) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Skill_Mastery (
    QuestID INT PRIMARY KEY,
    Skill VARCHAR(255),
    FOREIGN KEY (QuestID) REFERENCES Quest(QuestID) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Collaborative (
    QuestID INT PRIMARY KEY,
    Deadline DATE,
    Max_Num_Participants INT,
    FOREIGN KEY (QuestID) REFERENCES Quest(QuestID) ON DELETE CASCADE ON UPDATE CASCADE

);

    CREATE TABLE Badge (
    BadgeID int PRIMARY KEY,
    title VARCHAR(50),
    description VARCHAR(200),
    criteria VARCHAR(50),
    points int
);

	Create TABLE Discussion_forum (
	forumID int primary key,
	Course_ID int,
	Module_ID int,
	 FOREIGN KEY (Module_ID) REFERENCES Module(Module_ID) ON DELETE CASCADE ON UPDATE CASCADE,
	 FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) ON DELETE CASCADE ON UPDATE CASCADE,
	 title varchar(50),
	 last_active Date,
	 timestamp date,
	 description varchar(255)
	);

	CREATE TABLE Survey (
    ID INT PRIMARY KEY,         
    Title VARCHAR(255) NOT NULL  
);

CREATE TABLE SurveyQuestions (
    SurveyID INT,                  
    Question VARCHAR(255) NOT NULL,   
    PRIMARY KEY (SurveyID, Question), 
    FOREIGN KEY (SurveyID) REFERENCES Survey(ID) 
);
CREATE TABLE FilledSurvey (
    SurveyID INT,
    Question VARCHAR(255) NOT NULL,
    LearnerID INT,
    Answer TEXT NOT NULL,
    PRIMARY KEY (SurveyID, Question, LearnerID),
    FOREIGN KEY (SurveyID, Question) REFERENCES SurveyQuestions(SurveyID, Question),
    FOREIGN KEY (LearnerID) REFERENCES Learner(Learner_ID)
);