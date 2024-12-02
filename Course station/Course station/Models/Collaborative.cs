using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Collaborative")]
public partial class Collaborative
{
    [Key]
    [Column("QuestID")]
    public int QuestId { get; set; }

    public DateOnly? Deadline { get; set; }

    [Column("Max_Num_Participants")]
    public int? MaxNumParticipants { get; set; }

    [InverseProperty("Quest")]
    public virtual ICollection<LearnerCollaboration> LearnerCollaborations { get; set; } = new List<LearnerCollaboration>();

    [ForeignKey("QuestId")]
    [InverseProperty("Collaborative")]
    public virtual Quest Quest { get; set; } = null!;
}
