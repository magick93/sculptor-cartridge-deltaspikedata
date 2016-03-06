package org.sculptor.generator.cartridge.deltaspikedata

import org.junit.BeforeClass
import org.junit.Test
import org.sculptor.generator.test.GeneratorTestBase

import static org.sculptor.generator.test.GeneratorTestExtensions.*

/**
 * Tests that verify overall generator workflow for projects that have Spring Data JPA cartridge enabled
 */
class DeltaspikeDataGeneratorTest extends GeneratorTestBase {

	static val TEST_NAME = "deltaspikedata"

	new() {
		super(TEST_NAME)
	}

	@BeforeClass
	def static void setup() {
		runGenerator(TEST_NAME)
	}

//	@Test
//	def void assertRepositoryCustomInterface() {
//		val code = getFileText(TO_GEN_SRC + "/org/sculptor/example/library/media/domain/MediaRepositoryCustom.java");
//		assertContainsConsecutiveFragments(code, #[
//			"public interface MediaRepositoryCustom {",
//			"public List<Media> findMediaByCharacter(Long libraryId, String characterName);",
//			"public List<Media> findMediaByName(Long libraryId, String name);",
//			"public Map<String, Movie> findMovieByUrlIMDB(Set<String> keys);",
//			"}"
//		])
//	}
//
//	@Test
//	def void assertRepositoryCustomClass() {
//		val code = getFileText(
//			TO_SRC + "/org/sculptor/example/library/media/repositoryimpl/MediaRepositoryImpl.java");
//		assertContainsConsecutiveFragments(code, #[
//			"public class MediaRepositoryImpl implements MediaRepositoryCustom {",
//			"public MediaRepositoryImpl() {",
//			"}",
//			"public List<Media> findMediaByCharacter(Long libraryId, String characterName) {",
//			"// TODO Auto-generated method stub",
//			"throw new UnsupportedOperationException(\"findMediaByCharacter not implemented\");",
//			"}"
//		])
//	}
//
//	@Test
//	def void assertServiceBaseClass() {
//		val code = getFileText(
//			TO_GEN_SRC + "/org/sculptor/example/library/media/serviceimpl/MediaCharacterServiceImplBase.java");
//		assertContainsConsecutiveFragments(code, #[
//			"public MediaCharacterServiceImplBase() {",
//			"}",
//			"@Autowired",
//			"private MediaCharacterRepository mediaCharacterRepository;",
//			"protected MediaCharacterRepository getMediaCharacterRepository() {",
//			"return mediaCharacterRepository;",
//			"}",
//			"@Autowired",
//			"private LibraryRepository libraryRepository;",
//			"protected LibraryRepository getLibraryRepository() {",
//			"return libraryRepository;",
//			"}",
//			"@Autowired",
//			"private LibraryService libraryService;",
//			"protected LibraryService getLibraryService() {",
//			"return libraryService;",
//			"}"
//		])
//	}

}
