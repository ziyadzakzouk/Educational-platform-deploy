using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Interaction_log")]
public partial class InteractionLog
{
    [Key]
    [Column("LogID")]
    public int LogId { get; set; }

    [Column("activity_ID")]
    public int? ActivityId { get; set; }

    [Column("LearnerID")]
    public int? LearnerId { get; set; }

    public TimeOnly? Duration { get; set; }

    [Column(TypeName = "datetime")]
    public DateTime? Timestamp { get; set; }

    [Column("action_type")]
    [StringLength(50)]
    [Unicode(false)]
    public string? ActionType { get; set; }

    [ForeignKey("ActivityId")]
    [InverseProperty("InteractionLogs")]
    public virtual LearningActivity? Activity { get; set; }

    [ForeignKey("LearnerId")]
    [InverseProperty("InteractionLogs")]
    public virtual Learner? Learner { get; set; }
}
