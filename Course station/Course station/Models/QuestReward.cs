using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("QuestId", "RewardId", "LearnerId")]
[Table("QuestReward")]
public partial class QuestReward
{
    [Key]
    [Column("QuestID")]
    public int QuestId { get; set; }

    [Key]
    [Column("RewardID")]
    public int RewardId { get; set; }

    [Key]
    [Column("LearnerID")]
    public int LearnerId { get; set; }

    [Column("timeEarned", TypeName = "datetime")]
    public DateTime? TimeEarned { get; set; }

    [ForeignKey("LearnerId")]
    [InverseProperty("QuestRewards")]
    public virtual Learner Learner { get; set; } = null!;

    [ForeignKey("QuestId")]
    [InverseProperty("QuestRewards")]
    public virtual Quest Quest { get; set; } = null!;

    [ForeignKey("RewardId")]
    [InverseProperty("QuestRewards")]
    public virtual Reward Reward { get; set; } = null!;
}
