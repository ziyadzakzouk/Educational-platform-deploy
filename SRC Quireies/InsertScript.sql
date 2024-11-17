-- Insert data into Learner table
INSERT INTO Learner (Learner_ID, Name, Email, DateOfBirth)
VALUES (1, 'John Doe', 'john.doe@example.com', '1990-01-01');

-- Insert data into PersonalProfile table
INSERT INTO PersonalProfile (Profile_ID, Learner_ID, ProfileName, ProfileDescription)
VALUES (1, 1, 'Main Profile', 'This is the main profile of John Doe.');