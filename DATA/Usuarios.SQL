INSERT INTO public.usuarios (username, contrasena, activo, isadmin)
VALUES
    ('admin', 'admin123', true, true),       -- Usuario administrador
    ('ActiveUser', 'password1', true, false),  -- Usuario activo no administrador
    ('NonActiveUser', 'password2', true, false),  -- Usuario activo no administrador
    ('Guest360', 'guest123', false, false),    -- Usuario inactivo no administrador
    ('Admin2', 'root2023', true, true); -- Otro administrador activo
