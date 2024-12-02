using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("FeedbackId", "InstructorId")]
[Table("Emotionalfeedback_review")]
public partial class EmotionalfeedbackReview
{
    [Key]
    [Column("FeedbackID")]
    public int FeedbackId { get; set; }

    [Key]
    [Column("InstructorID")]
    public int InstructorId { get; set; }

    [Column("review")]
    [StringLength(500)]
    [Unicode(false)]
    public string? Review { get; set; }

    [ForeignKey("FeedbackId")]
    [InverseProperty("EmotionalfeedbackReviews")]
    public virtual EmotionalFeedback Feedback { get; set; } = null!;

    [ForeignKey("InstructorId")]
    [InverseProperty("EmotionalfeedbackReviews")]
    public virtual Instructor Instructor { get; set; } = null!;
}
