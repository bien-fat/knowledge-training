def chat_decode(text, roles=None):
    if roles is None:
        roles = ["system", "user", "assistant"]
    
    lines = text.strip().split('\n')
    messages = []
    current_role = None
    current_content = []
    
    for line in lines:
        if line in roles:
            if current_role is not None:
                messages.append({
                    "role": current_role,
                    "content": '\n'.join(current_content).strip()
                })
            current_role = line
            current_content = []
        else:
            current_content.append(line)
    
    if current_role is not None:
        messages.append({
            "role": current_role,
            "content": '\n'.join(current_content).strip()
        })
    
    return messages