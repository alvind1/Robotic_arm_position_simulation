function[abcd] = test_function(abcd)
    wxyz = containers.Map();
    wxyz('A') = 11;
    wxyz('B') = 123;
    abcd = containers.Map(wxyz.keys, wxyz.values);
end