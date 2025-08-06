package sports.util;

import java.util.*;

public class TFIDFSimilarity {

    private List<String> tokenize(String text) {
        return Arrays.asList(text.toLowerCase().split("\\W+"));
    }

    private Map<String, Double> computeTF(List<String> words) {
        Map<String, Double> tf = new HashMap<>();
        for (String word : words) {
            tf.put(word, tf.getOrDefault(word, 0.0) + 1.0);
        }
        int totalWords = words.size();
        for (String word : tf.keySet()) {
            tf.put(word, tf.get(word) / totalWords);
        }
        return tf;
    }

    private Map<String, Double> computeIDF(List<List<String>> allDocs) {
        Map<String, Double> idf = new HashMap<>();
        int totalDocs = allDocs.size();
        for (List<String> doc : allDocs) {
            Set<String> unique = new HashSet<>(doc);
            for (String word : unique) {
                idf.put(word, idf.getOrDefault(word, 0.0) + 1.0);
            }
        }
        for (String word : idf.keySet()) {
            idf.put(word, Math.log(totalDocs / idf.get(word)));
        }
        return idf;
    }

    private Map<String, Double> computeTFIDF(List<String> words, Map<String, Double> idf) {
        Map<String, Double> tf = computeTF(words);
        Map<String, Double> tfidf = new HashMap<>();
        for (String word : tf.keySet()) {
            tfidf.put(word, tf.get(word) * idf.getOrDefault(word, 0.0));
        }
        return tfidf;
    }

    private double cosineSimilarity(Map<String, Double> v1, Map<String, Double> v2) {
        Set<String> allWords = new HashSet<>(v1.keySet());
        allWords.addAll(v2.keySet());

        double dot = 0.0, norm1 = 0.0, norm2 = 0.0;
        for (String word : allWords) {
            double a = v1.getOrDefault(word, 0.0);
            double b = v2.getOrDefault(word, 0.0);
            dot += a * b;
            norm1 += a * a;
            norm2 += b * b;
        }

        return (norm1 == 0 || norm2 == 0) ? 0.0 : dot / (Math.sqrt(norm1) * Math.sqrt(norm2));
    }

    public List<Integer> getSimilarProducts(int targetId, Map<Integer, String> productDescriptions) {
        Map<Integer, List<String>> tokenized = new HashMap<>();
        List<List<String>> allDocs = new ArrayList<>();

        for (Map.Entry<Integer, String> entry : productDescriptions.entrySet()) {
            List<String> tokens = tokenize(entry.getValue());
            tokenized.put(entry.getKey(), tokens);
            allDocs.add(tokens);
        }

        Map<String, Double> idf = computeIDF(allDocs);
        Map<Integer, Map<String, Double>> tfidfVectors = new HashMap<>();
        for (Map.Entry<Integer, List<String>> entry : tokenized.entrySet()) {
            tfidfVectors.put(entry.getKey(), computeTFIDF(entry.getValue(), idf));
        }

        Map<String, Double> currentVector = tfidfVectors.get(targetId);
        Map<Integer, Double> similarityScores = new HashMap<>();

        for (Map.Entry<Integer, Map<String, Double>> entry : tfidfVectors.entrySet()) {
            if (entry.getKey() == targetId) continue;
            double sim = cosineSimilarity(currentVector, entry.getValue());
            similarityScores.put(entry.getKey(), sim);
        }

        List<Integer> sorted = new ArrayList<>(similarityScores.keySet());
        sorted.sort((a, b) -> Double.compare(similarityScores.get(b), similarityScores.get(a)));

        return sorted.subList(0, Math.min(4, sorted.size())); // top 4
    }
    
}
