using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace matrix.gnu.bin
{
    public class values
    {
        using System.Collections.Generic;
        using System.Linq;
        using System.Threading.Tasks;
        using Microsoft.AspNetCore.Builder;
        using Microsoft.AspNetCore.Hosting;
        using Microsoft.AspNetCore.Http;
        using Microsoft.Extensions.DependencyInjection;
        
        namespace WebApp
        {
            public class Startup
            {
                public void ConfigureServices(IServiceCollection services)
                {
                }
        
                public void Configure(IApplicationBuilder app, IHostingEnvironment env)
                {
                    if (env.IsDevelopment())
                    {
                        app.UseDeveloperExceptionPage();
                    }
        
                    app.Run(async (context) =>
                    {
                        await context.Response.WriteAsync("Hello World!");
                    });
                }
            }
        }
    }
}