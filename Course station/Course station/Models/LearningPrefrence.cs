using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("LearnerId", "Prefrences")]
public partial class LearningPrefrence
{
    [Key]
    [Column("Learner_ID")]
    public int LearnerId { get; set; }

    [Key]
    [Column("prefrences")]
    [StringLength(50)]
    [Unicode(false)]
    public string Prefrences { get; set; } = null!;

    [ForeignKey("LearnerId")]
    [InverseProperty("LearningPrefrences")]
    public virtual Learner Learner { get; set; } = null!;
}
