using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace Course_station.Models;

[Table("ContentLibrary")]
public partial class ContentLibrary
{
    [Key]
    [Column("Lib_ID")]
    public int LibId { get; set; }

    [Column("Module_ID")]
    public int? ModuleId { get; set; }

    [Column("Course_ID")]
    public int? CourseId { get; set; }

    [Column("title")]
    [StringLength(100)]
    [Unicode(false)]
    public string? Title { get; set; }

    [Column("description")]
    [StringLength(255)]
    [Unicode(false)]
    public string? Description { get; set; }

    [Column("metaData")]
    [StringLength(255)]
    [Unicode(false)]
    public string? MetaData { get; set; }

    [Column("type")]
    [StringLength(50)]
    [Unicode(false)]
    public string? Type { get; set; }

    [Column("contentURL")]
    [StringLength(255)]
    [Unicode(false)]
    public string? ContentUrl { get; set; }

    [ForeignKey("ModuleId, CourseId")]
    [InverseProperty("ContentLibraries")]
    public virtual Module? Module { get; set; }
}
