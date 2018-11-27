using StatisticalRethinking, Literate
using Test

chapters = ["00", "02", "03", "04"]
DocDir = joinpath(@__DIR__, "..", "docs", "src")

for chapter in chapters
  ProjDir = joinpath(@__DIR__, "..", "chapters", chapter)
  NotebookDir = joinpath(@__DIR__, "..", "notebooks", chapter)
  !isdir(NotebookDir) && mkdir(NotebookDir)
  println("\nSwitching to directory: $ProjDir\n")
  !isdir(ProjDir) && break
  cd(ProjDir) do
    
    filelist = readdir()
    for file in filelist
      if !isdir(file) && file[1:4] == "clip" && file[end-2:end] == ".jl"  
        
        fname = "snippets" * file[5:end-3]
        Literate.markdown(file, DocDir, name=fname, documenter=true)
        Literate.notebook(file, NotebookDir, name=fname)
        
      end # if file[1:4]
    end # for file
  end # cd
  println()
end # for chapter
