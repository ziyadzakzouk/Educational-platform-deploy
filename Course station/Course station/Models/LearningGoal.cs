using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Learning_goal")]
public partial class LearningGoal
{
    [Key]
    [Column("ID")]
    public int Id { get; set; }

    [Column("status")]
    [StringLength(20)]
    [Unicode(false)]
    public string Status { get; set; } = null!;

    [Column("deadline")]
    public DateOnly Deadline { get; set; }

    [Column("description", TypeName = "text")]
    public string Description { get; set; } = null!;

    [ForeignKey("GoalId")]
    [InverseProperty("Goals")]
    public virtual ICollection<Learner> Learners { get; set; } = new List<Learner>();
}
