using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("LearningPath")]
public partial class LearningPath
{
    [Key]
    [Column("Path_ID")]
    public int PathId { get; set; }

    [Column("Learner_ID")]
    public int? LearnerId { get; set; }

    [Column("profileID")]
    public int? ProfileId { get; set; }

    [Column("completion_status")]
    [StringLength(220)]
    [Unicode(false)]
    public string? CompletionStatus { get; set; }

    [Column("customContent")]
    [StringLength(255)]
    [Unicode(false)]
    public string? CustomContent { get; set; }

    [Column("adaptiveRules")]
    [StringLength(255)]
    [Unicode(false)]
    public string? AdaptiveRules { get; set; }

    [InverseProperty("Path")]
    public virtual ICollection<Pathreview> Pathreviews { get; set; } = new List<Pathreview>();

    [ForeignKey("LearnerId, ProfileId")]
    [InverseProperty("LearningPaths")]
    public virtual PersonalProfile? PersonalProfile { get; set; }
}
