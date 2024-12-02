using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("Discussion_forum")]
public partial class DiscussionForum
{
    [Key]
    [Column("forumID")]
    public int ForumId { get; set; }

    [Column("Course_ID")]
    public int? CourseId { get; set; }

    [Column("Module_ID")]
    public int? ModuleId { get; set; }

    [Column("title")]
    [StringLength(50)]
    [Unicode(false)]
    public string? Title { get; set; }

    [Column("last_active", TypeName = "datetime")]
    public DateTime? LastActive { get; set; }

    [Column("timestamp", TypeName = "datetime")]
    public DateTime? Timestamp { get; set; }

    [Column("description")]
    [StringLength(255)]
    [Unicode(false)]
    public string? Description { get; set; }

    [InverseProperty("Forum")]
    public virtual ICollection<LearnerDiscussion> LearnerDiscussions { get; set; } = new List<LearnerDiscussion>();

    [ForeignKey("ModuleId, CourseId")]
    [InverseProperty("DiscussionForums")]
    public virtual Module? Module { get; set; }
}
