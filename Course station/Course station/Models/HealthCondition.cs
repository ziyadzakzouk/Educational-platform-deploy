using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("LearnerId", "ProfileId", "Condition")]
[Table("HealthCondition")]
public partial class HealthCondition
{
    [Key]
    [Column("Learner_ID")]
    public int LearnerId { get; set; }

    [Key]
    [Column("profileID")]
    public int ProfileId { get; set; }

    [Key]
    [Column("condition")]
    [StringLength(50)]
    [Unicode(false)]
    public string Condition { get; set; } = null!;

    [ForeignKey("LearnerId, ProfileId")]
    [InverseProperty("HealthConditions")]
    public virtual PersonalProfile PersonalProfile { get; set; } = null!;
}
