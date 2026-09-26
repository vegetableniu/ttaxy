module("parser", package.seeall)
require("object")
Parser = Object({
  _init = {"grammar"}
})
function Parser:_clone(grammar)
  local init = table.permute(self._init, grammar)
  for rname, rule in pairs(init.grammar) do
    if name ~= "lexemes" then
      for pnum, prod in ipairs(rule) do
        local abstract
        for i, v in pairs(prod) do
          if type(i) == "string" and i ~= "action" then
            if abstract then
              print(prod)
              die("more than one abstract rule for " .. rname .. "." .. tostring(pnum))
            else
              if type(v) ~= "table" then
                die("bad abstract syntax rule of type " .. type(v))
              end
              abstract = {ty = i, template = v}
              prod[i] = nil
            end
          end
        end
        if abstract then
          prod.abstract = abstract
        end
      end
    end
  end
  local object = table.merge(self, init)
  return setmetatable(object, object)
end
function Parser:parse(start, token, from)
  local grammar = self.grammar
  local rule, symbol
  local function optional(sym, from)
    local tree, to = symbol(sym, from)
    if to then
      return tree, to
    else
      return false, from
    end
  end
  local function list(sym, sep, from)
    local tree, to
    tree, from = symbol(sym, from)
    local list = {tree}
    if from == false then
      return list, false
    end
    to = from
    repeat
      if sep ~= "" then
        tree, from = symbol(sep, from)
      end
      if from then
        tree, from = symbol(sym, from)
        if from then
          table.insert(list, tree)
          to = from
        end
      end
    until from == false
    return list, to
  end
  function symbol(sym, from)
    if string.sub(sym, -4, -1) == "_opt" then
      return optional(string.sub(sym, 1, -5), from)
    elseif string.find(sym, "_list.-$") then
      local _, _, subsym, sep = string.find(sym, "^(.*)_list_?(.-)$")
      return list(subsym, sep, from)
    elseif grammar[sym] then
      return rule(sym, from)
    elseif token[from] and (grammar.lexemes[sym] and sym == token[from].ty or sym == token[from].tok) then
      return token[from].tok, from + 1
    else
      return false, false
    end
  end
  local function production(name, prod, from)
    local tree = {ty = name}
    local to = from
    for _, prod in ipairs(prod) do
      local sym
      sym, to = symbol(prod, to)
      if to then
        table.insert(tree, sym)
      else
        return tree, false
      end
    end
    if prod.action then
      tree = prod.action(tree, token, to)
    end
    if prod.abstract then
      local ntree = {}
      ntree.ty = prod.abstract.ty
      for i, n in prod.abstract.template, nil, nil do
        ntree[i] = tree[n]
      end
      tree = ntree
    end
    return tree, to
  end
  function rule(name, from)
    local alt = grammar[name]
    local tree, to
    for _, alt in ipairs(alt) do
      tree, to = production(name, alt, from)
      if to then
        return tree, to
      end
    end
    return tree, false
  end
  return rule(start, 1, from or 1)
end
