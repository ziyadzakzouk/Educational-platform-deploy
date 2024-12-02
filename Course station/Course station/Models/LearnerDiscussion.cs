using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("ForumId", "LearnerId", "Post")]
[Table("LearnerDiscussion")]
public partial class LearnerDiscussion
{
    [Key]
    [Column("ForumID")]
    public int ForumId { get; set; }

    [Key]
    [Column("LearnerID")]
    public int LearnerId { get; set; }

    [Key]
    [Column("post")]
    [StringLength(255)]
    [Unicode(false)]
    public string Post { get; set; } = null!;

    [Column("time")]
    public TimeOnly? Time { get; set; }

    [ForeignKey("ForumId")]
    [InverseProperty("LearnerDiscussions")]
    public virtual DiscussionForum Forum { get; set; } = null!;

    [ForeignKey("LearnerId")]
    [InverseProperty("LearnerDiscussions")]
    public virtual Learner Learner { get; set; } = null!;
}
