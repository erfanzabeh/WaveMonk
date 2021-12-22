function value = recursive_read(struct, name)
    
    if isempty(struct)
        value = [];
        return;
    end

    if isfield(struct, name)
        value = struct.(name);
        return;
    end
    
    if isfield(struct, 'cfg')
        value = recursive_read(struct.cfg, name);
        return;
    elseif isfield(struct, 'previous')
        if isa(struct.previous, 'cell')
            if isempty(struct.previous)
                value = [];
                return;
            else
                value = recursive_read(struct.previous{1, 1}, name);
                return;
            end
        else
            value = recursive_read(struct.previous, name);
            return;
        end
    end
end