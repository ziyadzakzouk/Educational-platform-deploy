namespace Course_station.Service
{
    public class LearnerProfileViewModel
    {
        public int LearnerId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public DateTime Birthday { get; set; }
        public string Gender { get; set; }
        public string Country { get; set; }
        public string CulturalBackground { get; set; }
        public string Email { get; set; }
        public string PhotoPath { get; set; }
        public IFormFile Photo { get; set; } // For photo upload
    }
}
