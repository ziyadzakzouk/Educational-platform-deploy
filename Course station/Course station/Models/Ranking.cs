using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("BoardId", "LearnerId")]
[Table("Ranking")]
public partial class Ranking
{
    [Key]
    [Column("BoardID")]
    public int BoardId { get; set; }

    [Key]
    [Column("LearnerID")]
    public int LearnerId { get; set; }

    [Column("CourseID")]
    public int? CourseId { get; set; }

    [Column("rank")]
    public int Rank { get; set; }

    [Column("total_points")]
    public int TotalPoints { get; set; }

    [ForeignKey("BoardId")]
    [InverseProperty("Rankings")]
    public virtual Leaderboard Board { get; set; } = null!;

    [ForeignKey("CourseId")]
    [InverseProperty("Rankings")]
    public virtual Course? Course { get; set; }

    [ForeignKey("LearnerId")]
    [InverseProperty("Rankings")]
    public virtual Learner Learner { get; set; } = null!;
}
