using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Emotional_feedback")]
public partial class EmotionalFeedback
{
    [Key]
    [Column("FeedbackID")]
    public int FeedbackId { get; set; }

    [Column("LearnerID")]
    public int? LearnerId { get; set; }

    [Column("Activity_ID")]
    public int? ActivityId { get; set; }

    [Column("timestamp", TypeName = "datetime")]
    public DateTime? Timestamp { get; set; }

    [Column("emotional_state")]
    [StringLength(20)]
    [Unicode(false)]
    public string? EmotionalState { get; set; }

    [ForeignKey("ActivityId")]
    [InverseProperty("EmotionalFeedbacks")]
    public virtual LearningActivity? Activity { get; set; }

    [InverseProperty("Feedback")]
    public virtual ICollection<EmotionalfeedbackReview> EmotionalfeedbackReviews { get; set; } = new List<EmotionalfeedbackReview>();

    [ForeignKey("LearnerId")]
    [InverseProperty("EmotionalFeedbacks")]
    public virtual Learner? Learner { get; set; }
}
