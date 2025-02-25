function ]canvaholic  --description 'generate obsidian canvas svg'
    cat $argv[1] | docker run -i divan9/canvaholic:0 > "$argv[1].svg"
end
