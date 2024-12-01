

using System.ComponentModel.DataAnnotations;

namespace Course_station.Models
{
    public class Courses
    {

        [Key]
        public int CourseID { get; set; }

        [Required]
        [MaxLength(200)]
        public string CourseName { get; set; }

        [MaxLength(500)]
        public string Description { get; set; }

        [Required]
        public int InstructorID { get; set; } // FK for the Instructor teaching this course

        // Navigation property for the instructor
        public User Instructor { get; set; }

        // Navigation property for learners enrolled in this course
        public ICollection<User> EnrolledLearners { get; set; }

    }
}
