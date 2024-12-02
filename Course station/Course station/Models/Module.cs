using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[PrimaryKey("ModuleId", "CourseId")]
[Table("Module")]
public partial class Module
{
    [Key]
    [Column("Module_ID")]
    public int ModuleId { get; set; }

    [Key]
    [Column("Course_ID")]
    public int CourseId { get; set; }

    [Column("title")]
    [StringLength(100)]
    [Unicode(false)]
    public string? Title { get; set; }

    [Column("difficulty_level")]
    [StringLength(8)]
    [Unicode(false)]
    public string? DifficultyLevel { get; set; }

    [Column("contentURL")]
    [StringLength(255)]
    [Unicode(false)]
    public string? ContentUrl { get; set; }

    [InverseProperty("Module")]
    public virtual ICollection<Assessment> Assessments { get; set; } = new List<Assessment>();

    [InverseProperty("Module")]
    public virtual ICollection<ContentLibrary> ContentLibraries { get; set; } = new List<ContentLibrary>();

    [ForeignKey("CourseId")]
    [InverseProperty("Modules")]
    public virtual Course Course { get; set; } = null!;

    [InverseProperty("Module")]
    public virtual ICollection<DiscussionForum> DiscussionForums { get; set; } = new List<DiscussionForum>();

    [InverseProperty("Module")]
    public virtual ICollection<LearningActivity> LearningActivities { get; set; } = new List<LearningActivity>();

    [InverseProperty("Module")]
    public virtual ICollection<ModuleContent> ModuleContents { get; set; } = new List<ModuleContent>();

    [InverseProperty("Module")]
    public virtual ICollection<TargetTrait> TargetTraits { get; set; } = new List<TargetTrait>();
}
