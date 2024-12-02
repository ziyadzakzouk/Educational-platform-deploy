using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("LearnerId", "ProfileId")]
[Table("PersonalProfile")]
public partial class PersonalProfile
{
    [Key]
    [Column("Learner_ID")]
    public int LearnerId { get; set; }

    [Key]
    [Column("profileID")]
    public int ProfileId { get; set; }

    [Column("PreferedContent_type")]
    [StringLength(50)]
    [Unicode(false)]
    public string? PreferedContentType { get; set; }

    [Column("emotionalState")]
    [StringLength(50)]
    [Unicode(false)]
    public string? EmotionalState { get; set; }

    [Column("personality_type")]
    [StringLength(50)]
    [Unicode(false)]
    public string? PersonalityType { get; set; }

    [InverseProperty("PersonalProfile")]
    public virtual ICollection<HealthCondition> HealthConditions { get; set; } = new List<HealthCondition>();

    [ForeignKey("LearnerId")]
    [InverseProperty("PersonalProfiles")]
    public virtual Learner Learner { get; set; } = null!;

    [InverseProperty("PersonalProfile")]
    public virtual ICollection<LearningPath> LearningPaths { get; set; } = new List<LearningPath>();
}
