using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;
using Course_station.Models;

namespace Course_station.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ModuleController : ControllerBase
    {
        private readonly ApplicationDbContext _context;

        public ModuleController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: api/Module
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Module>>> GetModules()
        {
            return await _context.Modules.Include(m => m.Course).ToListAsync();
        }

        // GET: api/Module/5/1
        [HttpGet("{moduleId}/{courseId}")]
        public async Task<ActionResult<Module>> GetModule(int moduleId, int courseId)
        {
            var module = await _context.Modules
                .Include(m => m.Course)
                .FirstOrDefaultAsync(m => m.ModuleId == moduleId && m.CourseId == courseId);

            if (module == null)
            {
                return NotFound();
            }

            return module;
        }

        // POST: api/Module
        [HttpPost]
        public async Task<ActionResult<Module>> PostModule(Module module)
        {
            _context.Modules.Add(module);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetModule), new { moduleId = module.ModuleId, courseId = module.CourseId }, module);
        }

        // PUT: api/Module/5/1
        [HttpPut("{moduleId}/{courseId}")]
        public async Task<IActionResult> PutModule(int moduleId, int courseId, Module module)
        {
            if (moduleId != module.ModuleId || courseId != module.CourseId)
            {
                return BadRequest();
            }

            _context.Entry(module).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ModuleExists(moduleId, courseId))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // DELETE: api/Module/5/1
        [HttpDelete("{moduleId}/{courseId}")]
        public async Task<IActionResult> DeleteModule(int moduleId, int courseId)
        {
            var module = await _context.Modules.FindAsync(moduleId, courseId);
            if (module == null)
            {
                return NotFound();
            }

            _context.Modules.Remove(module);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ModuleExists(int moduleId, int courseId)
        {
            return _context.Modules.Any(e => e.ModuleId == moduleId && e.CourseId == courseId);
        }
    }
}
