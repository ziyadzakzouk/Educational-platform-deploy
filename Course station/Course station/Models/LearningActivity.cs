using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("learningActivity")]
public partial class LearningActivity
{
    [Key]
    [Column("Activity_ID")]
    public int ActivityId { get; set; }

    [Column("Course_ID")]
    public int? CourseId { get; set; }

    [Column("Module_ID")]
    public int? ModuleId { get; set; }

    [Column("activityType")]
    [StringLength(50)]
    [Unicode(false)]
    public string? ActivityType { get; set; }

    [Column("instruction_details")]
    [StringLength(255)]
    [Unicode(false)]
    public string? InstructionDetails { get; set; }

    [Column("maxScore")]
    public int? MaxScore { get; set; }

    [InverseProperty("Activity")]
    public virtual ICollection<EmotionalFeedback> EmotionalFeedbacks { get; set; } = new List<EmotionalFeedback>();

    [InverseProperty("Activity")]
    public virtual ICollection<InteractionLog> InteractionLogs { get; set; } = new List<InteractionLog>();

    [ForeignKey("ModuleId, CourseId")]
    [InverseProperty("LearningActivities")]
    public virtual Module? Module { get; set; }
}
