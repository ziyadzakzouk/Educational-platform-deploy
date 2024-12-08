using System.Collections.Generic;
using Course_station.Models;
namespace Course_station.Models { 
public class LearnerDetailsViewModel
{
    public Learner Learner { get; set; }
    public List<Course> EnrolledCourses { get; set; }
    public List<Skill> SkillsProficiency { get; set; }
    public List<Leaderboard> LeaderboardRank { get; set; }
    public List<Assessment> AssessmentsList { get; set; }
        public PersonalProfile PersonalProfile { get; set; }
    }
}