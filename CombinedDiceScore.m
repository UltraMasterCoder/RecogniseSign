function DSC = CombinedDiceScore(Iin, GT)

nGTLabels = max(max(GT));
nInLabels = max(max(Iin));

SumScore = 0;
nScores = 0;
% Run through all ground truth labels
for L = 1:nGTLabels
    maxDSC = 0;
    maxIDX = -1;
    GTL = (GT == L);
    % comment mkmk
    
    % Find the label with maximum dice score compare to GT label
    for Lin = 1:nInLabels
        INL = (Iin == Lin);
        DSC = DiceScore(GTL, INL);
        if DSC > maxDSC
            maxDSC = DSC;
            maxIDX = Lin;
        end
    end
    
    % Remove the found label that has already been "used"
    if maxIDX > 0
        Iin = changem(Iin, 0, maxIDX);
       % imagesc(Iin)
    end
    
    SumScore = SumScore + maxDSC;
    nScores = nScores + 1;
end

DSC = 0;

if nScores > 0
    DSC = SumScore / nScores;
end
