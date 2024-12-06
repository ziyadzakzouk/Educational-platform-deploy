using Course_station.Models;

public class LearnerPhotos
{
    public int LearnerPhotoId { get; set; } // Primary Key
    public int LearnerId { get; set; } // Foreign Key
    public string? PhotoPath { get; set; } // Make nullable

    // Navigation property
    public Learner? Learner { get; set; } // Make nullable
}
